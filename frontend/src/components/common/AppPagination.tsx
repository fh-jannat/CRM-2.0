import React from 'react';

interface AppPaginationProps {
  pageSize: number;
  pageNo: number;
  total: number;
  setPageNo: (page: number) => void;
  setPageSize: (size: number) => void;
}

export const AppPagination: React.FC<AppPaginationProps> = ({
  pageSize,
  pageNo,
  total,
  setPageNo,
  setPageSize,
}) => {
  const totalPages = Math.ceil(total / pageSize);

  const handlePrevPage = () => {
    if (pageNo > 1) {
      setPageNo(pageNo - 1);
    }
  };

  const handleNextPage = () => {
    if (pageNo < totalPages) {
      setPageNo(pageNo + 1);
    }
  };

  const handlePageSizeChange = (
    event: React.ChangeEvent<HTMLSelectElement>
  ) => {
    const newPageSize = parseInt(event.target.value, 10);
    setPageSize(newPageSize);
    // Adjust current page number if it exceeds the new total pages
    const newTotalPages = Math.ceil(total / newPageSize);
    if (pageNo > newTotalPages) {
      setPageNo(newTotalPages);
    }
  };

  const renderPageNumbers = () => {
    const pageNumbers = [];
    const showEllipsis = totalPages > 5;

    if (showEllipsis) {
      if (pageNo <= 3) {
        for (let i = 1; i <= 4; i++) {
          pageNumbers.push(i);
        }
        pageNumbers.push('...');
      } else if (pageNo >= totalPages - 2) {
        pageNumbers.push('...');
        for (let i = totalPages - 3; i <= totalPages; i++) {
          pageNumbers.push(i);
        }
      } else {
        pageNumbers.push('...');
        for (let i = pageNo - 1; i <= pageNo + 1; i++) {
          pageNumbers.push(i);
        }
        pageNumbers.push('...');
      }
    } else {
      for (let i = 1; i <= totalPages; i++) {
        pageNumbers.push(i);
      }
    }

    return pageNumbers.map((number, index) => (
      <button
        key={index}
        onClick={() => typeof number === 'number' && setPageNo(number)}
        className={`flex h-8 w-8 items-center justify-center rounded-md text-sm transition-colors ${
          number === pageNo
            ? 'bg-primaryColor text-white'
            : 'bg-white text-gray-700 hover:bg-gray-100'
        } ${typeof number !== 'number' ? 'cursor-default' : ''}`}
      >
        {number}
      </button>
    ));
  };

  return (
    <div className='my-8 flex items-center justify-center space-x-4'>
      <div className='flex items-center space-x-2'>
        <label htmlFor='pageSize' className='text-sm text-gray-600'>
          Items per page:
        </label>
        <select
          id='pageSize'
          value={pageSize}
          onChange={handlePageSizeChange}
          className='h-8 appearance-none rounded-md border border-gray-300 bg-white px-2 pr-8 text-sm text-gray-700 focus:border-primaryColor focus:outline-none'
          style={{
            backgroundImage: `url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='M6 8l4 4 4-4'/%3e%3c/svg%3e")`,
            backgroundRepeat: 'no-repeat',
            backgroundPosition: 'right 0.5rem center',
            backgroundSize: '1.5em 1.5em',
          }}
        >
          {[10, 20, 50, 100].map((size) => (
            <option key={size} value={size}>
              {size}
            </option>
          ))}
        </select>
      </div>
      <div className='flex items-center space-x-1'>
        <button
          onClick={handlePrevPage}
          disabled={pageNo === 1}
          className='flex h-8 w-8 items-center justify-center rounded-md bg-white text-gray-700 transition-colors hover:bg-gray-100 disabled:cursor-not-allowed disabled:opacity-50'
        >
          <svg
            xmlns='http://www.w3.org/2000/svg'
            className='h-5 w-5'
            viewBox='0 0 20 20'
            fill='currentColor'
          >
            <path
              fillRule='evenodd'
              d='M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z'
              clipRule='evenodd'
            />
          </svg>
        </button>

        {renderPageNumbers()}

        <button
          onClick={handleNextPage}
          disabled={pageNo === totalPages}
          className='flex h-8 w-8 items-center justify-center rounded-md bg-white text-gray-700 transition-colors hover:bg-gray-100 disabled:cursor-not-allowed disabled:opacity-50'
        >
          <svg
            xmlns='http://www.w3.org/2000/svg'
            className='h-5 w-5'
            viewBox='0 0 20 20'
            fill='currentColor'
          >
            <path
              fillRule='evenodd'
              d='M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z'
              clipRule='evenodd'
            />
          </svg>
        </button>
      </div>
    </div>
  );
};
